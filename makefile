SOURCES=$(shell find . -name "*/*.Rmd")
TARGET = $(SOURCES:%.Rmd=%.pdf) $(SOURCES:%.Rmd=%.html) $(SOURCES:%.Rmd=%.nb.html) $(SOURCES:%.Rmd=%.docx)

%.Rmd: %.R
	Rscript -e 'knitr::spin("$<", knit = FALSE, format = "Rmd")'

%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

index: index.Rmd
	Rscript -e 'rmarkdown::render("$<")'

site: index.Rmd errata.Rmd
	Rscript -e 'rmarkdown::render_site()'
