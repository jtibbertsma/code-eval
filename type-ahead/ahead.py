import sys
import re

string = """
Mary had a little lamb its fleece was white as snow;
And everywhere that Mary went, the lamb was sure to go.
It followed her to school one day, which was against the rule;
It made the children laugh and play, to see a lamb at school.
And so the teacher turned it out, but still it lingered near,
And waited patiently about till Mary did appear.
"Why does the lamb love Mary so?" the eager children cry; "Why, Mary loves the lamb, you know" the teacher did reply."
"""

class NGram:
  def __init__(self, text):
    self.followers = {}

    prev = None
    for word in re.findall("\\b\\w+\\b", text):
      if prev:
        if prev not in self.followers:
          self.followers[prev] = {}
        if word not in self.followers[prev]:
          self.followers[prev][word] = 0
        self.followers[prev][word] += 1
      prev = word

  def 