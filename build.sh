#!/bin/bash
#

slidedecks=("0-misp-introduction-to-information-sharing" "1-misp-usage")
mkdir output
export TEXINPUTS=::`pwd`/themes/
echo ${TEXINPUTS}
for slide in ${slidedecks[@]}; do
        cd ${slide}
        pdflatex slide.tex
        pdflatex slide.tex
        rm *.aux *.toc *.snm *.log *.out *.nav
        cp slide.pdf ../output/${slide}.pdf
        rm slide.pdf
        cd ..
done

echo "Generating ack page..."
cd complementary/ack
pdflatex ack.tex
rm *.aux *.log *.out
cp ack.pdf ../../output
cd ../..

echo "Generating handout..."
cd output
pdfunite *.pdf ../misp-training.pdf
cd ..
exiftool -Title="MISP Training and Slide Decks" -Author="CIRCL Computer Incident Response Center Luxembourg" -Subject="MISP Threat Intelligence Platform Training Materials" -Keywords="MISP Threat Intelligence CTI STIX information sharing yara sigma suricata snort bro openioc threat-actor TIP threat intelligence platform circl.lu training cybersecurity MISPProject" misp-training.pdf
