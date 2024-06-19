# FROM jupyter/minimal-notebook:latest
FROM quay.io/jupyter/minimal-notebook

USER root

# Add permanent apt-get installs and other root commands here
# e.g., RUN apt-get install --yes --no-install-recommends npm nodejs

USER ${NB_UID}

# Switch back to jovyan to avoid accidental container runs as root
# Add permanent mamba/pip/conda installs, data files, other user libs here
# e.g., RUN pip install --no-cache-dir flake8

# RUN pip install --quiet --no-cache-dir jupyter_contrib_nbextensions && \
#     jupyter contrib nbextension install --user && \
#     # can modify or enable additional extensions here
#     jupyter nbextension enable spellchecker/main --user && \
#     fix-permissions "${CONDA_DIR}" && \
#     fix-permissions "/home/${NB_USER}"

COPY requirements.txt /tmp/requirements.txt
# Install Python 3 packages
RUN pip install -r /tmp/requirements.txt
