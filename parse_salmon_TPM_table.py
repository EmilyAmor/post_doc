#!/usr/bin/env python

import click
import pandas

@click.command()
@click.argument('quant_sf')
@click.argument('output_file')
def parse_salmon_TPM_table(quant_sf, output_file):
  """ extract contigs that have a TPM > 2 from salmon quant.sf output file  """

  # read in quant.sf salmon output file
  t1 = pd.read_csv(quant_sf,sep='\t', engine='python')

  # extract contig names that TPM > 2
  transcripts_larger_2TPM = []
  for i in range(len(t1.index)):
      if t1.iloc[i, 3] > 2:
          transcripts_larger_2TPM.append(t1.iloc[i, 0])

  # write contig names that have TPM > 2  to txt file
  f = open(output_file, "w")
  for i in transcripts_larger_2TPM:
      f.write(i + '\n')

  f.close()

if __name__ == '__main__':
      parse_salmon_TPM_table()
