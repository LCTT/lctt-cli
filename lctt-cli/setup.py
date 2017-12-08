from setuptools import setup
from setuptools.command.test import test
import os

__version__='0.0.1'

here = os.path.abspath(os.path.dirname(__file__))
class PyTest(test):
    def finalize_options(self):
        test.finalize_options(self)
        self.test_args = []
        self.test_suite = True

setup(
    name='lctt-cli',
    version=__version__,
    url='http://github.com/lctt/lctt-cli',
    license='MIT License',
    author='wenkangji',
    author_email='jiwenkangatech@foxmail.com',
    description='solve lctt-cli translate of choose',
    platforms='any',
)
