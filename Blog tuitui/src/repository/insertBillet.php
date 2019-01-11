<?php
/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "test.php";
include "db.php";


$titre = $_POST['titre'];
$content = $_POST['corps_de_texte'];
$date_publication = $_POST['date_publication'];
//$image = addslashes(file_get_contents($_FILES['image']['tmp_name']));
$categorie = $_POST['theme'];

//var_dump($_FILES); die;
$fileName = $_FILES['image']['name'];
$tmp = $_FILES['image']['tmp_name'];

move_uploaded_file($tmp, 'C:/wamp64/www/3WA/Blog-Tuitui/Blog tuitui/public/images/voyages/'.$fileName);
//$_POST['image'] = $fileName; ne sert à rien


$data_billet = [
  'titre'=> $titre,
  'corps_de_texte' => $content,
  'publication' => $date_publication,
  'cat' => $categorie,
  'image' => $fileName
];


$insert_billet = $db -> prepare
('
  INSERT INTO billet (titre, corps_de_texte, image, date_publication, categorie)
  VALUES (:titre, :corps_de_texte, :image, :publication, :cat);
');

//corps_de_texte, categorie, date_publication
////:corps_de_texte, :cat, :publication
$insert_billet -> execute($data_billet);
//var_dump($data_billet);die;
//

//header('Location: ../../index.php');
?>
