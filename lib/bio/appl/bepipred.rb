#
# = bio/appl/bepipred.rb - Bepipred wrapper
# 
# Copyright::   Copyright (C) 2010 
#               George Githinji <georgkam@gmail.com>
# License::     The Ruby License
#
# $Id:$
#
##############################################################################
#   BepiPred predicts the location of linear B-cell epitopes in proteins using
#   a combination of a hidden Markov  model and a propensity scale method. The
#   method is described in the following article:
#
#   Improved method for predicting linear B-cell epitopes.
#   Jens Erik Pontoppidan Larsen, Ole Lund and Morten Nielsen
#   Immunome Research 2:2, 2006.

require 'bio/command'
require 'shellwords'

module Bio

  # == Description
  # 
  # A wrapper for Bepipred linear B-cell epitope prediction program.
  #
  # === Examples
  #
  #   require 'bio'
  #   seq_file = 'test.fasta'
  #  
  #   factory = Bio::Bepipred.new(seq_file)
  #   report = factory.query
  #   report.class # => Bio::Bepipred::Report
  #
class Bepipred
  autoload :Report, 'bio/appl/bepipred/report'
  
  # Creates a new Bepipred execution wrapper object
  def initialize(program='bepipred',opt=[])
    @program = program
    @options = opt
  end
  
  # name of the program (usually 'bepipred' in UNIX/Linux)
  attr_accessor :program

  # options
  attr_accessor :options
  
  
 private
 #executes bepipred when called localy
 def exec_local
  
 end
    
end  
end
