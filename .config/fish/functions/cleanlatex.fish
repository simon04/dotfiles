function cleanlatex
    find -name '*.aux' -o -name '*.log' -o -name '*.nav' -o -name '*.snm' -o -name '*.toc' -o -name '*.vrb' -o -name '*.dvi' -delete
end
