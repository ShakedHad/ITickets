//
//  StudentsTableViewController.swift
//  iTickets
//
//  Created by admin on 01/03/2020.
//  Copyright © 2020 ss. All rights reserved.
//

import UIKit

class TicketsTableViewController: UITableViewController {
    
    var data = [Ticket]();
    var selectedTicket:Ticket?;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        TicketsStore.instance.getAll{(tickets:[Ticket]) in
            self.data = tickets
            self.refreshControl?.endRefreshing();
            self.tableView.reloadData();
        };
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ("iTickets");
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
//        cell.postImageImageVIew.image = currentTicket.image;
        cell.postImageImageVIew.image = UIImage(named: "emptyArtist");
      
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
