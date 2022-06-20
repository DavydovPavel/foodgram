FROM python:3.8.5
WORKDIR /code
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN pip install --upgrade pip
COPY . .
RUN pip install wheel
RUN pip install -r requirements.txt
RUN python manage.py migrate
RUN python manage.py collectstatic --noinput
CMD gunicorn foodgram.wsgi:application --bind 0.0.0.0:8000