const sql = require("./db.js");

// constructor
const Vacina = function(vacinas) {
  this.nome_vacina = vacinas.nome_vacina;
  this.dosagem = vacinas.dosagem;
  this.validade = vacinas.validade;
  this.lote = vacinas.lote;
};

Vacina.create = (newvacinas, result) => {
  sql.query("INSERT INTO vacinas SET ?", newvacinas, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created vacinas: ", { id: res.insertId, ...newvacinas });
    result(null, { id: res.insertId, ...newvacinas });
  });
};

Vacina.findById = (id, result) => {
  sql.query(`SELECT * FROM vacinas WHERE id = ${id}`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found vacinas: ", res[0]);
      result(null, res[0]);
      return;
    }

    // not found vacinas with the id
    result({ kind: "not_found" }, null);
  });
};

Vacina.getAll = (title, result) => {
  let query = "SELECT * FROM vacinas";

  if (title) {
    query += ` WHERE title LIKE '%${title}%'`;
  }

  sql.query(query, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("vacinas: ", res);
    result(null, res);
  });
};

Vacina.getAllPublished = result => {
  sql.query("SELECT * FROM vacinas WHERE published=true", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("vacinas: ", res);
    result(null, res);
  });
};

Vacina.updateById = (id, vacinas, result) => {
  sql.query(
    "UPDATE vacinas SET title = ?, description = ?, published = ? WHERE id = ?",
    [vacinas.title, vacinas.description, vacinas.published, id],
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found vacinas with the id
        result({ kind: "not_found" }, null);
        return;
      }

      console.log("updated vacinas: ", { id: id, ...vacinas });
      result(null, { id: id, ...vacinas });
    }
  );
};

Vacina.remove = (id, result) => {
  sql.query("DELETE FROM vacinas WHERE id = ?", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      // not found vacinas with the id
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted vacinas with id: ", id);
    result(null, res);
  });
};

Vacina.removeAll = result => {
  sql.query("DELETE FROM vacinas", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log(`deleted ${res.affectedRows} vacinas`);
    result(null, res);
  });
};

module.exports = Vacina;
