//
//  PPSDBUserSQL.h
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#ifndef PPSDBUserSQL_h
#define PPSDBUserSQL_h



#define     USER_TABLE_NAME              @"user"
/**
 *  建表
 *
 *  @param uid   当前用户Corp邮箱前缀
 *  @param fid    好友Corp邮箱前缀
 *  @param email   Corp邮箱
 *
 *  @return
 */
#define     SQL_CREATE_USER_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                                        uid TEXT,\
                                                        name TEXT,\
                                                        email TEXT,\
                                                        phoneNum TEXT,\
                                                        ext1 TEXT,\
                                                        ext2 TEXT,\
                                                        ext3 TEXT,\
                                                        ext4 INTEGER DEFAULT (0),\
                                                        ext5 INTEGER DEFAULT (0),\
                                                        ext6 INTEGER DEFAULT (0),\
                                                        PRIMARY KEY(uid))"

#define     SQL_ADD_USER               @"INSERT OR REPLACE INTO %@ ( uid, name, email, phoneNum, ext1, ext2, ext3, ext4, ext5, ext6) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_USER              @"SELECT * FROM %@ WHERE uid = '%@'"

#define     SQL_GET_ALL_USER              @"SELECT * FROM %@ "

#define     SQL_DELETE_USER               @"DELETE FROM %@ WHERE uid = '%@'"

#define     SQL_UPDATE_USER                @"UPDATE %@ SET name = ?, email = ?, phoneNum = ? WHERE uid = '%@' "


#endif /* PPSDBUserSQL_h */
