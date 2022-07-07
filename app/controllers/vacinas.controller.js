const Vacina = require("../models/vacina.model.js");

exports.create = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
  }

  const vacinas = new Vacina({
    nome_vacina: req.body.nome_vacina,
    dosagem: req.body.dosagem,
    validade: req.body.validade,
    lote: req.body.lote
  });

  // Save Tutorial in the database
  Vacina.create(vacinas, (err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Some error occurred while creating the vacinas."
      });
    else res.send(data);
  });
};

exports.findAll = (req, res) => {
  const title = req.query.title;

  Vacina.getAll(title, (err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving vacinas."
      });
    else res.send(data);
  });
};

exports.findOne = (req, res) => {
  Vacina.findById(req.params.id, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found vacinas with id ${req.params.id}.`
        });
      } else {
        res.status(500).send({
          message: "Error retrieving vacinas with id " + req.params.id
        });
      }
    } else res.send(data);
  });
};

exports.findAllPublished = (req, res) => {
  Vacina.getAllPublished((err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving vacinas."
      });
    else res.send(data);
  });
};

exports.update = (req, res) => {
  // Validate Request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
  }

  Vacina.updateById(
    req.params.id,
    new Tutorial(req.body),
    (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found vacinas with id ${req.params.id}.`
          });
        } else {
          res.status(500).send({
            message: "Error updating vacinas with id " + req.params.id
          });
        }
      } else res.send(data);
    }
  );
};

exports.delete = (req, res) => {
  Vacina.remove(req.params.id, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found vacinas with id ${req.params.id}.`
        });
      } else {
        res.status(500).send({
          message: "Could not delete vacinas with id " + req.params.id
        });
      }
    } else res.send({ message: `vacinas was deleted successfully!` });
  });
};


exports.deleteAll = (req, res) => {
  Vacina.removeAll((err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Some error occurred while removing all vacinas."
      });
    else res.send({ message: `All Vacibas were deleted successfully!` });
  });
};
