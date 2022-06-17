echo "Installing additional jupyterlab extensions"
# install collapsible headings
echo "Installing jupyterlab collapsible headings extension"
jupyter labextension install @aquirdturtle/collapsible_headings --no-build

# install table of contents
echo "Installing jupyterlab table of contents extension"
jupyter labextension install @jupyterlab/toc --no-build

# install language protocol
echo "Installing jupyterlab language server protocol extension"
jupyter labextension install @krassowski/jupyterlab-lsp --no-build

# install tqdm notebook extension
jupyter nbextension enable --py widgetsnbextension
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build

# build jupyter lab for extensions to take effect
echo "Building jupyterlab with new extensions... this will take some time"
jupyter lab build
echo "Successfully installed extensions"
