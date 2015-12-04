//
//  LDWHDF5Dataset.swift
//  OpalStability
//
//  Created by Lee Walsh on 3/12/2015.
//  Copyright © 2015 Lee David Walsh. All rights reserved.
//

import Cocoa

class LDWHDF5Dataset: NSObject {
    var file_id: hid_t
    var dataset_id: hid_t
    var data = UnsafeMutablePointer<Int32>()
    var dims = [hsize_t](count:2, repeatedValue:0)
    var i: size_t
    var j: size_t
    var rows: size_t
    var numValues: size_t
    
    let H5F_ACC_RDONLY: UInt32 = 0x0000
    let H5P_DEFAULT = 0 as hid_t

    init(fileURL: NSURL){
        print("Initialising hdf5 dataset")
        //open the file at the supplied URL
        file_id = H5Fopen(fileURL.path!, H5F_ACC_RDONLY, H5P_DEFAULT);
        
        //open the exisiting dataset
        dataset_id = H5Dopen2(file_id, "/dset", H5P_DEFAULT);
        
        //read the dataset
//        H5LTread_dataset_int(file_id, "/dset", data)
        
        i = 0x0000
        j = 0x0000
        rows = 0x0000
        numValues = 0x0000
    }
}

/*
int main( void )
    {
        hid_t       file_id;
        int         data[6];
        hsize_t     dims[2];
        size_t     i, j, nrow, n_values;
        
        /* open file from ex_lite1.c */
        file_id = H5Fopen ("ex_lite1.h5", H5F_ACC_RDONLY, H5P_DEFAULT);
        
        /* read dataset */
        H5LTread_dataset_int(file_id,"/dset",data);
        
        /* get the dimensions of the dataset */
        H5LTget_dataset_info(file_id,"/dset",dims,NULL,NULL);
        
        /* print it by rows */
        n_values = (size_t)(dims[0] * dims[1]);
        nrow = (size_t)dims[1];
        for (i=0; i<n_values/nrow; i++ )
        {
            for (j=0; j<nrow; j++)
            printf ("  %d", data[i*nrow + j]);
            printf ("\n");
        }
        
        /* close file */
        H5Fclose (file_id);
        
        return 0;
        
        
}*/
