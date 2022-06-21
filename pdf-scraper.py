# https://www.geeksforgeeks.org/downloading-pdfs-with-python-using-requests-and-beautifulsoup/

import re

from bs4 import BeautifulSoup
from requests import get

from os.path import sep
from os import mkdir

url='https://www.perl.org/books/beginning-perl/'
soup=BeautifulSoup(get(url).text,'html.parser')

feature_list=soup.find('div',class_='feature_list')

save_dir='src1'

try:
    mkdir(save_dir)
except FileExistsError:
    pass

for a in feature_list.find_all('a'):
    if 'href' not in a.attrs or 'google' in a['href'] or re.search('.pdf$',a['href']) is None:
        continue
    pdf_name=a['href'].split('/')[-1]
    pdf_name=sep.join([save_dir,pdf_name])
    pdf=open(pdf_name,'wb')
    response=get(a.get('href'))
    pdf.write(response.content)
    pdf.close()
