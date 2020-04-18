//
//  StudentsTableViewController.swift
//  iTickets
//
//  Created by admin on 01/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit
import Kingfisher

class MyTicketsTableViewController: UITableViewController {
    
    var data = [Ticket]();
    var selectedTicket:Ticket?;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        ModelEvents.TicketUpdatedDataEvent.observe{
            self.reloadData()
        }
        
        ModelEvents.TicketDeletedDataEvent.observe{
            self.reloadData()
        }
        
        self.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        reloadData();
    }
    
    @objc func reloadData(){
        if(self.refreshControl?.isRefreshing == false){
                self.refreshControl?.beginRefreshing()
        }
        
        UsersStore.instance.getLoggedUser {user in
            TicketsStore.instance.getUserTickets(seller: user){(tickets:[Ticket]) in
                self.data = tickets
                self.tableView.reloadData();
                self.refreshControl?.endRefreshing();
            };
        }
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
        return ("My Tickets");
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyTicketsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTicketCell", for: indexPath) as! MyTicketsTableViewCell
        
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
        performSegue(withIdentifier: "UpdateTicketSegue", sender: self);
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateTicketSegue" {
            (segue.destination as! UpdateTicketViewController).ticket = selectedTicket;
        }
    }
}
