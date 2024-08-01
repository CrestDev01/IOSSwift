//
//  ToDoListViewController.swift
//  IOSSwift
//
//  Created by CrestAdmin on 26/07/24.
//

import Foundation
import UIKit
import SVProgressHUD

class ToDoListViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var toDolistTableView: UITableView!
    
    // MARK: - Properties
    var arrTodos :[ToDoModel] = [
        ToDoModel(todoId: 1, userId: 1, categoryId: 1, categoryName: "Personal", title: "Appointment", description: "Doctor's appointment at 6pm. Call at clicling for appointment confirmation."),
        ToDoModel(todoId: 1, userId: 1, categoryId: 2, categoryName: "Work", title: "Meeting", description: "New project lead meeting with German client. Add team members to call if required"),
        ToDoModel(todoId: 1, userId: 1, categoryId: 1, categoryName: "Personal", title: "Grocery", description: "Shop for coming week grocery need."),
        ToDoModel(todoId: 1, userId: 1, categoryId: 1, categoryName: "Personal", title: "Pickup", description: "Pickup kids from school when they return from a trip"),
        ToDoModel(todoId: 1, userId: 1, categoryId: 2, categoryName: "Work", title: "Project", description: "Assign new project to team.")]
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toDolistTableView.reloadData()
        self.navigationItem.title = JobListTitle
        
        self.toDolistTableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserToDoListFromServer()
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        self.pushViewController(with: .home, viewcontroller: AppConstant.viewcontroller.addEditJobVC)
    }
}

//MARK: - TableView Management
extension ToDoListViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        cell.todo = self.arrTodos[indexPath.row]
        cell.selectionStyle = .none
        
        return cell;
    }
    

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    let call = UIContextualAction(style: .normal, title: "Edit") { action, view, complete in
        let vc = UIStoryboard.getViewController(fromStoryboard: .home, withIdentifier: AppConstant.viewcontroller.addEditJobVC) as! AddEditToDoViewController
        vc.isEdit = true
        // vc.job = self.arrJobs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        complete(true)

    }

    call.backgroundColor = .green

    let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, complete in
    complete(true)
        
        let yes : UIAlertAction = UIAlertAction(title: YesTitle, style: .default) { UIAlertAction in
            // Call API here
        }
        let no : UIAlertAction = UIAlertAction(title: NoTitle, style: .cancel) { _ in
        }
       
        GeneralUtility.showAlert(onVC: self, withTitle: AlertTitle, message: DeleteAlertMesssgae, actions: [yes,no])
        
    }
    delete.image?.withTintColor(.white)
    delete.backgroundColor = .red

    return UISwipeActionsConfiguration(actions: [delete,call])

    }
}

extension ToDoListViewController{
    
    func getUserToDoListFromServer(){
    
        // Call your API here
        
    }
    
    func deleteToDoListFromServer(){
    
        // Call your API here
        
    }
}

