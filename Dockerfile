FROM python:3.6-alpine

WORKDIR /usr/src/

# Yes, i know, it is possible and VERY likely to make one RUN call with &&
# but overhead is not big, from the other hand, investigation "why it's not working" is much simpler.

RUN apk add git gcc musl-dev postgresql-dev
RUN pip install pipenv 

# FROM
RUN git clone https://github.com/shacker/gtd.git
WORKDIR /usr/src/gtd

RUN pipenv --python 3.6
RUN pipenv install --dev
ADD local.py project/.
ADD entrypoint.sh .
RUN chmod +x entrypoint.sh 

CMD [ "./entrypoint.sh" ]