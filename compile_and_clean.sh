#!/bin/bash

# Script to compile LaTeX and clean up temporary files

LATEX_FILE="latex_app_report_final.ltx"
PDF_NAME="latex_app_report_final.pdf"

echo "🔨 Compiling LaTeX document..."
echo ""

# First pass
echo "📄 Pass 1/3..."
pdflatex -interaction=nonstopmode "$LATEX_FILE" > /dev/null 2>&1

# Second pass (for references and TOC)
echo "📄 Pass 2/3..."
pdflatex -interaction=nonstopmode "$LATEX_FILE" > /dev/null 2>&1

# Third pass (to ensure everything is resolved)
echo "📄 Pass 3/3..."
pdflatex -interaction=nonstopmode "$LATEX_FILE" > /dev/null 2>&1

echo ""
echo "🧹 Cleaning up temporary files..."

# Remove all LaTeX auxiliary files
rm -f *.aux *.log *.out *.toc *.lof *.lot *.synctex.gz *.fdb_latexmk *.fls

echo ""
if [ -f "$PDF_NAME" ]; then
    FILE_SIZE=$(du -h "$PDF_NAME" | cut -f1)
    PAGE_COUNT=$(pdfinfo "$PDF_NAME" 2>/dev/null | grep "Pages:" | awk '{print $2}')
    
    echo "✅ Compilation successful!"
    echo "📊 PDF Details:"
    echo "   - File: $PDF_NAME"
    echo "   - Size: $FILE_SIZE"
    if [ ! -z "$PAGE_COUNT" ]; then
        echo "   - Pages: $PAGE_COUNT"
    fi
    echo ""
    echo "🎉 Done! Your PDF is ready."
else
    echo "❌ Error: PDF file was not generated."
    exit 1
fi
