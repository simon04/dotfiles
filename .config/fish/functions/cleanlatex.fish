function cleanlatex
    shopt -s nullglob
    rm -f *.{aux,log,nav,out,snm,toc,vrb,dvi,*latexmk}
end
