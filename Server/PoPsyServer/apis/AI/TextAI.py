import pickle
from tensorflow.keras.layers import Flatten, Dense, Input
from tensorflow.keras.models import Model
from tensorflow.keras.layers import BatchNormalization
from tensorflow.keras.layers import Dropout
from tensorflow.keras.optimizers import Adam
from googletrans import Translator
import re

def load_nn():
    input_layer = Input(shape=(6631))
    x = Dense(units=100, activation="relu")(input_layer)
    x = Dropout(rate=0.7)(x)

    output_layer = Dense(units=13, activation="softmax")(x)

    model = Model(input_layer, output_layer)
    opt = Adam()
    model.compile(loss="categorical_crossentropy", optimizer=opt, metrics=["accuracy"])
    model.load_weights("model1.h5")
    return model

model = load_nn()
translator = Translator()
tokenizer = pickle.load(open("tokenizer.picle", 'rb'))

def textPreprosses(text):
    temp = Translator.translate(text).text
    temp = re.sub(r"(@.*?)(\s|$)", "", temp)
    temp = re.sub(r"(http:\/\/.*?)(\s|$)", "", temp)
    temp.replace("#", "")
    return tokenizer.transform(temp).toarray()

def predictEmotion(text):
    value = textPreprosses(text);
    return model.predict(value);