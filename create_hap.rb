#!/usr/bin/env ruby

require 'bio'
require 'bio-alignment'
require 'bio-alignment/bioruby'
require 'bigbio'
include Bio::BioAlignment

aln = Alignment.new
count = 0; #The number of sequences in the fasta file

#fasta = FastaReader.new('/home/jearl/projects/mc201403n35/mauve/trial.aln.fasta')
fasta = FastaReader.new('short_trial.aln.fasta')

fasta.each do | rec |
  count += 1
  aln.sequences << Sequence.new(rec.descr,rec.seq)
end


puts count
puts aln[1][1]
