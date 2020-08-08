---
layout: post
title: Understanding about JavaFX
bigimg: /img/path.jpg
tags: [JavaFx]
---





<br>

## Table of contents
- [Structure of application in JavaFX](#structure-of-application-in-javafx)
- [Create ComboBox](#create-combobox)
- [Create TreeView](#create-treeview)
- [Create ListView](#create-listview)
- [Create TableView](#create-tableview)
- [Creat FileChooser and DirectoryChooser](#create-filechooser-and-directorychooser)
- [Create new Window](#create-new-window)
- [Wrapping up](#wrapping-up)


<br>

## Structure of application in JavaFX





<br>

## Create ComboBox

0. Prepare the structure of our data

    ```java
    @Data
    @AllArgsConstructor
    @NoArgConstructor
    public class Planet {
 
        public String code;
        private String name;
        
        @Override
        public String toString()  {
            return this.name;
        }
    }
    ```

1. Get our data

    ```java
    ObservableList<Planet> list = PlanetDAO.getPlanetList();
    ```

2. Push data into our ComboBox

    ```java
    ComboBox<Planet> comboBox = new ComboBox<Planet>();
    comboBox.setItems(list);
    comboBox.getSelectionModel().select(1);

    FlowPane root = new FlowPane();
    root.setPadding(new Insets(5));
    root.setHgap(5);
        
    root.getChildren().add(new Label("Select Planet:"));
    root.getChildren().add(comboBox);

    stage.setTitle("ComboxBox");
    Scene scene = new Scene(root, 350, 300);
    stage.setScene(scene);
    stage.show();
    ```

<br>

## Create TreeView

Assuming that we want to create TreeView that is as same as a below image.

![](../img/JavaFX/controls/tree-view/ex-tree-view.png)

0. Prepare the fields of each TreeItem's structure

    ```java
    @Data
    @AllArgsConstructor
    @NoArgConstructor
    public class BookCategory {
 
        private String code;
        private String name;
    
        @Override
        public String toString()  {
            return this.name;
        }
    }
    ```

1. Determine what is our rootItem of TreeView

    ```java
    BookCategory catJava = new BookCategory("JAVA-00", "Java");
    BookCategory catJSP = new BookCategory("JAVA-01", "Jsp");
    BookCategory catSpring = new BookCategory("JAVA-02", "Spring");

    TreeItem<BookCategory> rootItem = new TreeItem<BookCategory>(catJava);
    rootItem.setExpanded(true);
    ```

2. Create child TreeItems for TreeView

    ```java
    // JSP Item
    TreeItem<BookCategory> itemJSP = new TreeItem<BookCategory>(catJSP);

    // Spring Item
    TreeItem<BookCategory> itemSpring = new TreeItem<>(catSpring);
    ```

3. Add rootItem to TreeView and display it

    ```java
    // add child item to root item of TreeView
    rootItem.getChildren().addAll(itemJSP, itemSpring);

    TreeView<BookCategory> tree = new TreeView<BookCategory>(rootItem);

    // create 
    StackPane root = new StackPane();
    root.setPadding(new Insets(5));
    root.getChildren().add(tree);

    primaryStage.setTitle("JavaFX TreeView");
    primaryStage.setScene(new Scene(root, 300, 250));
    primaryStage.show();
    ```


<br>

## Create ListView

0. Prepare the fields of each CheckboxItem's structure

    ```java
    @Data
    @AllArgsConstructor
    @NoArgConstructor
    public class Book {
 
        private Long id;
        private String code;
        private String name;
    
        @Override
        public String toString() {
            return this.name;
        }
    }
    ```

1. Create a list of instances that we need to display

    ```java
    Book book1 = new Book(1L, "J01", "Java IO Tutorial");
    Book book2 = new Book(2L, "J02", "Java Enums Tutorial");
    Book book3 = new Book(2L, "C01", "C# Tutorial for Beginners");

    ObservableList<Book> books = FXCollections.observableArrayList(book1, book2, book3);
    ```

2. Add that list of instances into Checkbox

    ```java
    ListView<Book> listView = new ListView<Book>(books);

    // allow for selecting multiple choices
    listView.getSelectionModel().setSelectionMode(SelectionMode.MULTIPLE);

    listView.getSelectionModel().selectIndices(1, 2);
    listView.getFocusModel().focus(1);

    StackPane root = new StackPane();
    root.getChildren().add(listView);

    stage.setTitle("JavaFX ListView");

    Scene scene = new Scene(root, 350, 200);
    ```

4. Add event listener for clicking each List View's item

    ```java
    listView.getSelectionModel().selectedItemProperty().addListener(new ChangeListener<Book>() {
        @Override
        public void changed(ObservableValue<? extends Book> observable, Book oldValue, Book newValue) {
            label.setText("OLD: " + oldValue + ",  NEW: " + newValue);
        }
    });
    ```

## Create TableView

In JavaFX, TableView contains **TableColumn**s and **TableCell**s.

![](../img/JavaFX/controls/table-view/structure-table-view.png)

0. Prepare our data for fill in TableView

    ```java
    public class UserAccount {
        private Long id;
        private String userName;
        private String email;
        private String firstName;
        private String lastName;
        private boolean active;
    }
    ```

1. Create TableColumns

    ```java
    // UserName column
    TableColumn<UserAccount, String> userNameCol //
            = new TableColumn<UserAccount, String>("User Name");

    // Email column
    TableColumn<UserAccount, String> emailCol//
            = new TableColumn<UserAccount, String>("Email");

    // FullName column
    TableColumn<UserAccount, String> fullNameCol//
            = new TableColumn<UserAccount, String>("Full Name");

    // Create two child column - First Name, Last Name for FullName column
    TableColumn<UserAccount, String> firstNameCol //
            = new TableColumn<UserAccount, String>("First Name");

    TableColumn<UserAccount, String> lastNameCol //
            = new TableColumn<UserAccount, String>("Last Name");

    // Add them to FullName column
    fullNameCol.getColumns().addAll(firstNameCol, lastNameCol);

    // Active Column
    TableColumn<UserAccount, Boolean> activeCol//
            = new TableColumn<UserAccount, Boolean>("Active");
    ```

2. Create TableView and add all child columns into TableView

    ```java
    TableView<UserAccount> table = new TableView<UserAccount>();table.getColumns().addAll(userNameCol, emailCol, fullNameCol, activeCol);
 
    StackPane root = new StackPane();
    root.setPadding(new Insets(5));
    root.getChildren().add(table);

    stage.setTitle("TableView");

    Scene scene = new Scene(root, 450, 300);
    stage.setScene(scene);
    stage.show();
    ```

3. Fill data to Table View

    ```java
    // Fill each field of UserAccount class to corresponding TableColumn
    userNameCol.setCellValueFactory(new PropertyValueFactory<>("userName"));
    emailCol.setCellValueFactory(new PropertyValueFactory<>("email"));
    firstNameCol.setCellValueFactory(new PropertyValueFactory<>("firstName"));
    lastNameCol.setCellValueFactory(new PropertyValueFactory<>("lastName"));
    activeCol.setCellValueFactory(new PropertyValueFactory<>("active"));

    // sort by userName
    userNameCol.setSortType(TableColumn.SortType.DESCENDING);
    lastNameCol.setSortable(false);

    ObservableList<UserAccount> list = getUserList();
    table.setItems(list);
    ```

<br>

## Creat FileChooser and DirectoryChooser

1. Action with FileChooser

    ```java
    FileChooser fileChooser = new FileChooser();
    fileChooser.setTitle("Select Some Files");
    fileChooser.setInitialDirectory(new File(System.getProperty("user.home")));

    // select one file
    File file = fileChooser.showOpenDialog(primaryStage);

    // select multiple files
    List<File> files = fileChooser.showOpenMultipleDialog(primaryStage);
    ```

2. Action with DirectoryChooser

    ```java
    DirectoryChooser directoryChooser = new DirectoryChooser();
    // set title of DirectoryChooser
    directoryChooser.setTitle("Select Some Directories");
    fileChooser.getExtensionFilters().addAll(
                new FileChooser.ExtensionFilter("All Files", "*.*"), 
                new FileChooser.ExtensionFilter("JPG", "*.jpg"),
                new FileChooser.ExtensionFilter("PNG", "*.png"));

    // set folder at the first time
    directoryChooser.setInitialDirectory(new File(System.getProperty("user.home")));

    // select folder
    File dir = directoryChooser.showDialog(primaryStage);
    ```

## Create new Window

```java
Label secondLabel = new Label("I'm a Label on new Window");
 
StackPane secondaryLayout = new StackPane();
secondaryLayout.getChildren().add(secondLabel);

Scene secondScene = new Scene(secondaryLayout, 230, 100);

// Một cửa sổ mới (Stage)
Stage newWindow = new Stage();
newWindow.setTitle("Second Stage");
newWindow.setScene(secondScene);

// Sét đặt vị trí cho cửa sổ thứ 2.
// Có vị trí tương đối đối với cửa sổ chính.
newWindow.setX(primaryStage.getX() + 200);
newWindow.setY(primaryStage.getY() + 100);

newWindow.show();
```


<br>

<br>

## Wrapping up

- Understanding about how to create the basic components in Java FX.

<br>

Refer:

[http://www.java2s.com/Tutorials/Java/JavaFX/1300__JavaFX_CSS.htm](http://www.java2s.com/Tutorials/Java/JavaFX/1300__JavaFX_CSS.htm)

[https://o7planning.org/vi/11009/javafx](https://o7planning.org/vi/11009/javafx)

[https://examples.javacodegeeks.com/desktop-java/javafx/fxml/javafx-fxml-controller-example/](https://examples.javacodegeeks.com/desktop-java/javafx/fxml/javafx-fxml-controller-example/)

[https://o7planning.org/vi/11147/huong-dan-javafx-treeview](https://o7planning.org/vi/11147/huong-dan-javafx-treeview)

[https://www.callicoder.com/javafx-css-tutorial/](https://www.callicoder.com/javafx-css-tutorial/)

[http://blog.buildpath.de/fxml-composition-how-to-get-the-controller-of-an-included-fxml-view-nested-controllers/](http://blog.buildpath.de/fxml-composition-how-to-get-the-controller-of-an-included-fxml-view-nested-controllers/)

[http://blog.buildpath.de/fxml-composition-how-to-get-the-controller-of-an-included-fxml-view-nested-controllers/](http://blog.buildpath.de/fxml-composition-how-to-get-the-controller-of-an-included-fxml-view-nested-controllers/)