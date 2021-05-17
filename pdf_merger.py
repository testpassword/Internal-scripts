from PyPDF2 import PdfFileMerger
from argparse import ArgumentParser
from PIL import Image
import os


def convert(file):
    ext = file.split('.')[-1]
    if ext == 'pdf': return file
    elif ext in ['jpg', 'jpeg', 'png']:
        image = Image.open(file)
        image.convert('RGB')
        filename = f'{file}.pdf'
        image.save(filename)
        return filename
    else:
        raise TypeError('unsupported extension')


p = ArgumentParser()
p.add_argument('--src', type=str, required=True, help='Input files separated by ",". Supports png, jpg and pdf files')
p.add_argument('--res', type=str, help='name of output file', default='merged.pdf')
args = p.parse_args()
pdfs = [convert(f) for f in args.src.split(',')]
m = PdfFileMerger()
for pdf in pdfs:
    m.append(pdf)
m.write(args.res)
m.close()
for pdf in pdfs:
    os.remove(pdf)
