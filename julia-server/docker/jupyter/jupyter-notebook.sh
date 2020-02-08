#!/bin/bash

export PATH="/usr/local/julia/bin:$PATH"
. ~/.julia/conda/3/bin/activate

# install jupyter
conda install jupyter

# install julia jupyter kernel
julia -e 'using Pkg; Pkg.add("IJulia");'

# ログインパスワード設定
password='password'
hash=`python -c "from notebook.auth import passwd; print(passwd('$password'))"`
sed -i -e "s/^c\.NotebookApp\.password.*\$/c.NotebookApp.password = '$hash'/" ~/.jupyter/jupyter_notebook_config.py

# run jupyter notebook
jupyter notebook --ip=0.0.0.0 --no-browser /var/www/note/
