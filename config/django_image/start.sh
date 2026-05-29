#!/bin/bash

if [ ! -f /usr/src/app/manage.py ]; then
    django-admin startproject app .
fi

python manage.py makemigrations
python manage.py migrate

python manage.py shell << EOF
from django.contrib.auth.models import User
if not User.objects.filter(username='$DJANGO_SUPERUSER_USERNAME').exists():
    User.objects.create_superuser('$DJANGO_SUPERUSER_USERNAME', '$DJANGO_SUPERUSER_EMAIL', '$DJANGO_SUPERUSER_PASSWORD')
EOF

python manage.py runserver 0.0.0.0:8000