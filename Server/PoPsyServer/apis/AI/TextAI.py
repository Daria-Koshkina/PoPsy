import pickle
from tensorflow.keras.layers import Dense, Input
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Dropout
from tensorflow.keras.optimizers import Adam
from googletrans import Translator
import re


class TextAI:

    def __init__(self):
        self.model = self.load_nn()
        self.translator = Translator()
        self.tokenizer = pickle.load(open("tokenizer.picle", 'rb'))

    def load_nn(self):
        input_layer = Input(shape=(6631))
        x = Dense(units=100, activation="relu")(input_layer)
        x = Dropout(rate=0.7)(x)

        output_layer = Dense(units=13, activation="softmax")(x)

        model = Model(input_layer, output_layer)
        opt = Adam()
        model.compile(loss="categorical_crossentropy", optimizer=opt, metrics=["accuracy"])
        model.load_weights("model1.h5")
        return model

    def text_preprosses(self, text):
        temp = Translator.translate(text).text
        temp = re.sub(r"(@.*?)(\s|$)", "", temp)
        temp = re.sub(r"(http:\/\/.*?)(\s|$)", "", temp)
        temp.replace("#", "")
        return self.tokenizer.transform(temp).toarray()

    def predictEmotion(self, text):
        value = self.text_preprosses(text);
        return self.model.predict(value);