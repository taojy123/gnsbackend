
set PYTHONPATH=%PYTHONPATH%;env\Lib\site-packages;env\Lib

python manage.py migrate

start python deamon.py

python manage.py runserver 0.0.0.0:8000
