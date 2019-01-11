<?php
/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "db.php";


$displayBillet = $db -> prepare
('
  SELECT b.*, ut.pseudo, cat.nom
  FROM billet as b
  INNER JOIN utilisateur AS ut ON ut.id = b.auteur
  INNER JOIN categorie AS cat ON cat.id = b.categorie
  WHERE b.id = ?
');

$displayBillet -> execute([$_GET['id']]);
$displayBillet_result = $displayBillet -> fetch(PDO::FETCH_ASSOC);

?>
