#!/usr/bin/env python

import click
import pandas as pd

@click.command()
@click.argument('blast_table')
@click.argument('output_file')

def count_uniq_transcripts_blast_outputfmt6(blast_table, output_file):
    """ Count how many unique transcripts hit each gene from a blast output format 6 table  """

    df = pd.read_csv(blast_table,sep='\t', header=None, engine='python')
    counts =  df.groupby(0)[1].nunique()

    counts.to_csv(output_file, sep='\t', header=False)



if __name__ == '__main__':
    count_uniq_transcripts_blast_outputfmt6()
