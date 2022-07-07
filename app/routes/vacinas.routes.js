module.exports = app => {
    const vacinas = require("../controllers/vacinas.controller.js");
  
    var router = require("express").Router();
  
    // Create a new Vacinas
    router.post("/", vacinas.create);
  
    // Retrieve all Vacinas
    router.get("/", vacinas.findAll);
  
    // Retrieve a single Vacinas with id
    router.get("/:id", vacinas.findOne);
  
    // Update a Vacinas with id
    router.put("/:id", vacinas.update);
  
    // Delete a Vacinas with id
    router.delete("/:id", vacinas.delete);
  
    // Delete all Vacinas
    router.delete("/", vacinas.deleteAll);
  
    app.use('/vacinas', router);
  };
  