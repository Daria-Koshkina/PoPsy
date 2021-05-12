from .. import models
from sklearn.neighbors import NearestNeighbors
import numpy as np

class Rcomendaror:
    def __init__(self):
        self.audio = []
        self.video = []
        self.article = []

    def get_nearest(self, user, other_users):

        user_data = np.array(user)
        other_data = np.array(other_users)

        if user_data.shape[0] == 0 or other_data.shape[0] == 0 :
            self.nearest = 0
            return
        neighbors = NearestNeighbors(n_neighbors=1)
        neighbors.fit(other_data)
        self.nearest = neighbors.kneighbors(user_data,1, return_distance=False)[0][0]
        return self.nearest

    def fill_recomendatioms(self, view, general, recomedations):
        i = 0
        view_s = len(set(view))
        while i < 2 and len(recomedations) < len(general) and len(recomedations) < view_s:
            index = np.random.randint(0,len(view))
            if not view[index] in recomedations:
                recomedations.append(view[index])
                i += 1

        while i < 3 and len(recomedations) < len(general):
            index = np.random.randint(0,len(general))
            if not general[index] in recomedations:
                recomedations.append(general[index])
                i += 1


    def generate_recomendations(self, audio, video, article, audioV, videoV, articleV):
        self.fill_recomendatioms(self, audioV, audio, self.audio)
        self.fill_recomendatioms(self, videoV, video, self.video)
        self.fill_recomendatioms(self, articleV, article, self.article)
        return self.audio + self.video + self.article








