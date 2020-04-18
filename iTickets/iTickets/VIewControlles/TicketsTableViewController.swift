//
//  StudentsTableViewController.swift
//  iTickets
//
//  Created by admin on 01/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit
import Kingfisher

class TicketsTableViewController: UITableViewController, authenticationDelegate {
    var data = [Ticket]();
    var selectedTicket:Ticket?;
    var myTicketsViewController:UIViewController?;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        self.reloadData()
        
        ModelEvents.TicketAddedDataEvent.observe{
            self.reloadData()
        }
        
        ModelEvents.TicketUpdatedDataEvent.observe{
            self.reloadData()
        }
        
        ModelEvents.TicketDeletedDataEvent.observe{
            self.reloadData()
        }
        
        myTicketsViewController = (self.tabBarController?.viewControllers![1])!;
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        drawloginlogoutbuttons();
    }
    
    func drawloginlogoutbuttons() {
        if UsersStore.instance.doesUserLogged() {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.logout(sender:)));
            if (self.tabBarController?.viewControllers?.count == 1) {
                var tabsViewControllers = self.tabBarController?.viewControllers;
                tabsViewControllers?.append(self.myTicketsViewController!);
                self.tabBarController?.viewControllers = tabsViewControllers;
            }
            
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Login", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.login(sender:)));
            if (self.tabBarController?.viewControllers?.count == 2) {
                var tabsViewControllers = self.tabBarController?.viewControllers;
                tabsViewControllers?.removeLast();
                self.tabBarController?.viewControllers = tabsViewControllers;
            }
        }
    }
    
    @objc func login(sender: UIBarButtonItem) {
        LoginViewController.show(sender: self);
    }
    
    func onLoginSuccess() {
        drawloginlogoutbuttons();
    }
    
    func onLoginFailed() {
        
    }
    
    @objc func logout(sender: UIBarButtonItem) {
        UsersStore.instance.logout();
        drawloginlogoutbuttons();
    }
    
    @objc func reloadData(){
        if(self.refreshControl?.isRefreshing == false){
                self.refreshControl?.beginRefreshing()
        }
        
        TicketsStore.instance.getAll{(tickets:[Ticket]) in
            self.data = tickets
            self.tableView.reloadData();
            self.refreshControl?.endRefreshing();
        };
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ("Tickets Feed");
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TicketsCellViewController = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketsCellViewController
        
        let currentTicket:Ticket = data[indexPath.row];
        cell.artistLabel.text = currentTicket.artist;
        cell.locationLabel.text = currentTicket.location;
        
        let formatter = DateFormatter();
        formatter.dateFormat = "dd/MM/yyyy, HH:mm";
        cell.dateLabel.text = formatter.string(from: currentTicket.time);
        cell.priceLabel.text = String(currentTicket.price)+"₪";
        cell.postImageImageVIew.image = UIImage(named: "emptyArtist");
        
        if(currentTicket.image != ""){
            cell.postImageImageVIew.kf.setImage(with: URL(string: currentTicket.image))
        }

        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTicket = data[indexPath.row];
        performSegue(withIdentifier: "ticketInfoSegue", sender: self);
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ticketInfoSegue" {
            (segue.destination as! TicketInfoViewController).ticket = selectedTicket;
        }
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}
