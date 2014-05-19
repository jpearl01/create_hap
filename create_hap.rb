#!/usr/bin/env ruby

require 'bio'
require 'bio-alignment'
require 'bio-alignment/bioruby'
require 'bigbio'
include Bio::BioAlignment


#Quick method to check if the current column contains a snp or not
class Array
  def same_values?
    self.uniq.length == 1
  end
end

#Initialize variables
aln       = Alignment.new
count     = 0; #The number of sequences in the fasta file
positions = [] #track the position in the array where the snp was found
len_msa   = 0
snp_num = 0
snps = []

#Read the file, 
fasta = FastaReader.new('/home/jearl/projects/mc201403n35/mauve/core_w_macacae.aln.fasta')


fasta.each do | rec |
  count += 1
  aln.sequences << Sequence.new(rec.descr,rec.seq)
  len_msa = rec.seq.length
end

for i in (0..len_msa-1)
  b = aln.map{|row| row[i]} 
  #Check for gaps, or 'n' characters (not allowed in orderedPainting), may need more checks if additional IUPAC characters included
  if b.same_values? or b.include?('-') or b.include?('N') or b.include?('n')
    next
  else
    snp_num += 1
    positions.push(i)
    snps << aln.map{|row| row[i]}
  end
end

#Build header, and print out SNPs
puts '0'
puts count.to_s
puts positions.size.to_s
print 'P '
puts positions.join(' ')
puts "S" * positions.size

snps = snps.transpose
for i in (0..count-1)
  puts snps[i].join("").upcase
end
