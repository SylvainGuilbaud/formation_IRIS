FROM jupyter/base-notebook

# RUN pip install pandas numpy matplotlib && \
RUN pip install dataclass_csv numpy pandas geopy chronyk requests mysql.connector folium openpyxl names postgres matplotlib random-address phone-gen && \
    # wget --continue https://github.com/intersystems-community/iris-driver-distribution/raw/main/DB-API/intersystems_irispython-3.2.0-py3-none-any.whl && \
    wget --continue https://github.com/intersystems-community/iris-driver-distribution/blob/main/DB-API/intersystems_iris-3.3.0-py3-none-any.whl && \
    # pip install intersystems_irispython-3.2.0-py3-none-any.whl && \
    pip install intersystems_iris-3.3.0-py3-none-any.whl && \
    # rm intersystems_irispython-3.2.0-py3-none-any.whl
    rm intersystems_iris-3.3.0-py3-none-any.whl

# run without password
CMD start.sh jupyter lab --LabApp.token=''