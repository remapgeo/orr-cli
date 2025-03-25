from unidecode import unidecode
import re

import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords

try:
    stop_words = set(stopwords.words('portuguese'))
except LookupError:
    nltk.download('stopwords')
    stop_words = set(stopwords.words('portuguese'))
    

stop_words.remove('não')
stop_words.remove('com')
stop_words.remove('sem')

def remove_stopwords(text):
    # Tokenizar o texto em palavras
    try:
        words = word_tokenize(text, language='portuguese')
    except LookupError:
        nltk.download('punkt')
        words = word_tokenize(text, language='portuguese')
    # Filtrar as stop words
    filtered_words = [word for word in words if word.lower() not in stop_words]
    # Juntar as palavras filtradas de volta em uma string
    filtered_text = '_'.join(filtered_words).replace('_,_',',')
    
    return filtered_text

def normalize(s):
    try:
        return unidecode(remove_stopwords(s.lower().replace('\r','').rstrip()))
    except:
        return s
    
def normalize_remove(s):
    try:
        if int(s) == 0:
            return '0'
    except:
        ...
    try:
        s = re.sub(r'\s+', ' ',re.sub(r'[\(\)-]', '', s))
        return normalize(s).strip('_')
    except Exception:
        return s