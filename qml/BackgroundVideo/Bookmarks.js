.pragma library

var db;
var searchcriteria = "";
// opens database at launch
function openDB()
{
    db = openDatabaseSync("BookmarksDB","1.0","Bookmarks Database",1000000);
    createTable();

}



// creates table if it doesn't exist, otherwise ignores
function createTable()
{
    db.transaction(
       function(tx) {
          tx.executeSql("CREATE TABLE IF NOT EXISTS bookmarks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, url TEXT, creationdate TEXT, stream TEXT, modified DATETIME)");
       }
    )
}

// deletes table
function dropTable()
{
    db.transaction(
       function(tx) {
          tx.executeSql("DROP TABLE IF EXISTS bookmarks");
       }
    )
}

// creates a single bookmark record
function createBookmark(bookmarkItem)
{
    db.transaction(
       function(tx) {
          tx.executeSql("INSERT INTO bookmarks (title, url, creationdate, stream, modified) VALUES(?,?,?,?,?)",[bookmarkItem.title, bookmarkItem.url, bookmarkItem.creationdate, bookmarkItem.stream, bookmarkItem.modified]);
       }
    )
}

// updates a single bookmark record
function updateBookmark(bookmarkItem)
{
    db.transaction(
       function(tx) {
                    tx.executeSql("UPDATE bookmarks SET title = ?, url = ?, creationdate = ?, stream = ?, modified = ? WHERE id = ?",
                        [bookmarkItem.title, bookmarkItem.url, bookmarkItem.creationdate, bookmarkItem.stream, bookmarkItem.modified, bookmarkItem.id]);
       }
    )
}

// deletes a single bookmark record
function deleteBookmark(id)
{
    db.transaction(
       function(tx) {
          tx.executeSql("DELETE FROM bookmarks WHERE id = ?", [id]);
       }
    )
}
// read list of bookmarks
function search(model)
{
    model.clear();
    if (searchcriteria === "") {
        model.clear();
        var sqlstringer = "SELECT id, title, url, creationdate, stream FROM bookmarks";
        db.readTransaction(
           function(tx) {
              var rs;
              rs = tx.executeSql(sqlstringer);
                 for (var i = 0; i < rs.rows.length; i++) {
                    model.append(rs.rows.item(i))
                 }
           }
        )
    }

    else {
        model.clear();
        var sqlstring = "SELECT id, title, url, creationdate, stream FROM bookmarks";
        sqlstring += " WHERE url LIKE '%" + searchcriteria + "%' OR title LIKE '%" + searchcriteria + "%'"
        db.readTransaction(
           function(tx) {
              var rs;
              rs = tx.executeSql(sqlstring);
                 for (var i = 0; i < rs.rows.length; i++) {
                    model.append(rs.rows.item(i))
                 }
           }
        )
    }
}

function readBookmarkList(model)
{
    model.clear();
    var sqlstring = "SELECT id, title, url, creationdate, stream FROM bookmarks";

        db.readTransaction(
           function(tx) {
              var rs;
              rs = tx.executeSql(sqlstring);
                 for (var i = 0; i < rs.rows.length; i++) {
                    model.append(rs.rows.item(i))
                 }
           }
        )

}



// read a single bookmark item
function readBookmarkItem(id) {
    var data = {}
    db.readTransaction(
       function(tx) {
          var rs = tx.executeSql("SELECT * FROM bookmarks WHERE id=?", [id])
          if(rs.rows.length === 1) {
             data = rs.rows.item(0)
          }
       }
    )
    return data;
}

// create a default bookmark item
function defaultItem()
{
    return {title: "", url: "", creationdate: new Date(), stream:"", modified: new Date()}
}

function checkURL(url){
    var rs = "SELECT id, title, url, creationdate, stream FROM bookmarks";
    console.log(rs.rows.url(1).attribute)

}


