module.exports = {
    "up": "CREATE TABLE vacinas (id INT NOT NULL, UNIQUE KEY id (id), name VARCHAR(200) )",
    "down": "DROP TABLE vacinas"
}