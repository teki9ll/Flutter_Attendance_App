from django.contrib import admin
from .models import *

admin.site.register(Teachers)
admin.site.register(Classes)
admin.site.register(Students)
admin.site.register(Attend)
admin.site.register(HTTPResponse)