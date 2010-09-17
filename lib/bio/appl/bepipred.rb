#!/usr/bin/env ruby
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


require '/home/martin/bioruby/lib/bio/command'
#require 'shellwords'

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
  autoload :Report, '/home/martin/bioruby/lib/bio/appl/bepipred/report'
  
  # Creates a new Bepipred execution wrapper object
  #def initialize(program='bepipred',score_threshold=0.35,file_name)
  def initialize(program = '/usr/local/bepipred-1.0b/bepipred',score_threshold=0.35,file_name='/usr/local/bepipred-1.0b/test/Pellequer.fsa',options = [])
    #@program is a instance variable, and is available to all the methods of the class Bepipred. 
    #As you can see it’s used by methods make_command and query
    @program = program
    @score_threshold = score_threshold
    @file_name = file_name
    @options = [ '-h', '-k', '-s', 't #', '-V'] # switches
    @output  = ''
  end

  # name of the program ('bepipred' in UNIX/Linux)
  attr_accessor :program

  # options
  attr_accessor :score_threshold
  
  # return the names of the input sequences
  attr_reader :sequence_names
  
  def sequence_names(file)
    sequence_names = []
    Bio::FlatFile.auto(@file) do |f|
      f.each do |entry|
        sequence_names << entry.definition
      end
    end
    sequence_names
  end
  
  # TODO create a list of query sequences

  

print "\n\n111-in reached heare\n"

  # Executes the Bepipred search and returns the report 
  # (Bio::Bepipred::Report object).
  def make_command
    cmd = [@program," -t #{@score_threshold} ",@file_name]

    report = nil

    @output = Bio::Command.query_command(cmd,nil)
    #report = Bio::Command.query_command(cmd)
    report = parse_result(@output)

    return report

  end
  

  def parse_result(data)
    Report.new(data)
  end
  


  #query the file 
  def query(file_name)
    cmd = make_command
    exec_local(cmd)
  end  
  
  # TODO create a parser class for the ouput
  # parse_results

 #private
 #executes bepipred when called localy
 #The input is a file name or a path to the file containing protein sequences in fasta format
 #This method does not work
 # There could be a bug in the way the cmd aregument is created.
 #def exec_local(cmd)
  # Bio::Command.query_command(cmd)
 #end



end
end 
g = Bio::Bepipred.new()

#execute 
g.make_command
