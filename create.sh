tar xf src.tar || py python/pdf-scraper.py
cd src
my_rename() {
    for i in $1*.pdf; do mv $i ${i/$1/} 2>/dev/null; done;
}
# Strip away all the 3145_, Chap, App, and leading 0's
my_rename 3145_
my_rename App && my_rename Chap && my_rename 0
cd ..
echo Intro.pdf > files.txt
ls src/ | grep -P -v "Intro|Index" | grep -P "\d" | sort -g >> files.txt
ls src/ | grep [A-J]\.pdf >> files.txt
echo Index.pdf >> files.txt
for i in $(cat files.txt); do pdfinfo ./src/$i | grep Pages: | sed s/Pages:\\s*//; done > page-counts.txt
for i in $(cat files.txt); do less ./src/$i | head -n 1 | sed s/^\\s*//; done > titles.txt
echo Please append "P2P.Wrox.Com" to line 34 of titles.txt. Press the Return key.
read
vi titles.txt # 24: Append " P2P.Wrox.Com"
mv {titles,files,page-counts}.txt stats/
pdflatex main && pdflatex main
