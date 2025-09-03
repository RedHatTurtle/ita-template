# Diretório onde os arquivos temporários e o PDF serão
# gerados por latexmk.
#
# Mantenha sincronizado com o valor em .gitignore
OUT_DIR ?= build
TKZ_DIR ?= $(OUT_DIR)/tikz

# Opções passadas para latexmk.
LATEXMK_FLAGS ?= -xelatex -shell-escape --synctex=1

TKZ_SRCS := $(shell find . -type f -name "*.tikz.tex")	# This extension can change
TEX_SRCS := $(shell find . -type f -name "*.tex")
BIB_SRCS := $(shell find . -type f -name "*.bib")
IMG_SRCS := $(shell find . -type f -name "*.jpg" -or -name "*.png" -or -name "*.eps")

SRCS := $(TEX_SRCS) $(BIB_SRCS) $(IMG_SRCS)

# Receitas de compilação do Makefile
all: compile copy
.PHONY: all

compile: $(SRCS)
	@mkdir -p $(OUT_DIR)
	@mkdir -p $(TKZ_DIR)
	@latexmk $(LATEXMK_FLAGS) -output-directory=$(OUT_DIR) main.tex
	@make copy

copy:
	@cp $(OUT_DIR)/main.pdf .

clean:
	@echo "Removed /$(OUT_DIR)"
	@rm -rf $(OUT_DIR)

cleanall: clean
	@rm ./main.pdf
