abstract class StorageService {
  Future<List> getSavedVideos();
  Future<void> saveVideos(int value);
}