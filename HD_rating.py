from mrjob.job import MRJob
from mrjob.step import MRStep

class MovieRatingCount (MRJob):
    def steps(self):
        return [
            MRStep(mapper=self.mapper_movie_ratings,
                   reducer=self.reducer_ratings_sum)
        ]

    def mapper_movie_ratings(self, _, line):
        (userID, movieID, rating, timestamp) = line.split('\t')
        yield movieID, 1

    def reducer_ratings_sum(self, key, value):
        yield key,sum(value)


if __name__ == '__main__':
   MovieRatingCount.run()
