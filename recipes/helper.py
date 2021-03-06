import operator
from functools import reduce

from django.db.models import Q

from .models import TAG_CHOICES


def tag_collect(request):
    tags = []
    for label, _ in TAG_CHOICES:
        if request.GET.get(label, ""):
            tags.append(label)
    if tags:
        tags_filter = reduce(
            operator.or_, (Q(tags__contains=tag)for tag in tags))
        return tags, tags_filter
    else:
        return tags, None
