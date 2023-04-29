import RealmSwift

class MovieTitleRealm: Object {
    
    @Persisted var original_title: String = ""
    @Persisted var id: Int = 0
    @Persisted var original_name: String = ""
    @Persisted var overview: String = ""
    @Persisted var media_type: String = ""
    @Persisted var poster_path: String = ""
    @Persisted var vote_count: Int = 0
    @Persisted var vote_average: Double = 0
    @Persisted var release_date: String = ""
    
    override static func primaryKey() -> String? {
         return "id"
     }
}
