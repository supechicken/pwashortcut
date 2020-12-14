from flask import Flask, render_template, redirect, url_for, send_from_directory
from threading import Thread
import os

app = Flask(__name__)
