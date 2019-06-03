FROM python:3

#ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir /code
WORKDIR /code


COPY requirements.txt /code/

#RUN pip install -r requirements.txt
RUN pip install pipenv
RUN pipenv --no-site-packages venv
RUN . venv/bin/activate
COPY Pipfile Pipfile.lock /code/
RUN pipenv install -- system


COPY ./docker-entrypoint.sh /docker-entrypoint.sh
#RUN chmod +x ./docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

#ENTRYPOINT ["sh", "/docker-entrypoint.sh"]

CMD ["python3 manage.py runserver"]

COPY . /code/