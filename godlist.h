#ifndef GODLIST_H
#define GODLIST_H

#include <QObject>
#include <QStandardItemModel>
#include <QMutex>

class GodList : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QAbstractItemModel* objectsModel
               READ getFullObjectsModel
               NOTIFY objectsModelChanged)
    Q_PROPERTY(QAbstractItemModel* notNullObjectsModel
               READ getNotNullObjectsModel
               NOTIFY notNullObjectsModelChanged)

public:
    explicit GodList(QObject *parent = nullptr);

    Q_INVOKABLE QAbstractItemModel* getFullObjectsModel();
    Q_INVOKABLE QAbstractItemModel* getNotNullObjectsModel();
    int addNewObject(QString name,
                                  int count, float price);

    int modifyObject(int id, QString name,
                                 int count, float price);

    void buyGod(int id);
    void addGod(QString name,
                 int count, float price);
    void modifyGod(int id, QString name,
                    int count, float price);

    Q_INVOKABLE void startThreadBuyGod(int id);
    Q_INVOKABLE void startThreadAddGod(QString name,
                                        int count, float price);
    Q_INVOKABLE void startThreadModifyGod(int id, QString name,
                                           int count, float price);

    void readFromCSV();

signals:
    void objectsModelChanged();
    void notNullObjectsModelChanged();

private:
    QAbstractItemModel* objectsModel;
    QAbstractItemModel* notNullObjectsModel;
    QMutex databaseMutex;
};

#endif // GODLIST_H
