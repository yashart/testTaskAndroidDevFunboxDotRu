#include "godlist.h"
#include "goditem.h"
#include <QDebug>
#include <QtConcurrent/QtConcurrent>
#include <QFile>

GodList::GodList(QObject *parent) : QObject(parent)
{
    objectsModel = new QStandardItemModel(this);
    objectsModel->insertColumn(0);
    notNullObjectsModel = new QStandardItemModel(this);
    notNullObjectsModel->insertColumn(0);
}

QAbstractItemModel* GodList::getFullObjectsModel(){
    return this->objectsModel;
}

QAbstractItemModel* GodList::getNotNullObjectsModel(){
    notNullObjectsModel->removeRows(0, notNullObjectsModel->rowCount());
    int notNullCount = 0;
    GodItem item;
    for (int i = 0; i < this->objectsModel->rowCount(); i++) {
        item = (objectsModel->data(objectsModel->index(i, 0))).value<GodItem>();
        if (item.getCount() > 0) {
            notNullCount = this->notNullObjectsModel->rowCount();
            this->notNullObjectsModel->insertRow(notNullCount);
            notNullObjectsModel->setData(notNullObjectsModel->index(notNullCount, 0),
                                         QVariant::fromValue(item),
                                         Qt::DisplayRole);
        }
    }
    return this->notNullObjectsModel;
}

int GodList::addNewObject(QString name,
                          int count, float price) {
    int newRow = this->objectsModel->rowCount();
    GodItem newGodItem = GodItem(newRow, name, count, price);
    this->objectsModel->insertRow(newRow);
    this->objectsModel->setData(objectsModel->index(newRow, 0),
                                QVariant::fromValue(newGodItem),
                                Qt::EditRole);
    emit objectsModelChanged();
    emit notNullObjectsModelChanged();
    return 0;
}

int GodList::modifyObject(int id, QString name,
                          int count, float price) {
    GodItem newGodItem = GodItem(id, name, count, price);
    this->objectsModel->setData(objectsModel->index(id, 0),
                                QVariant::fromValue(newGodItem),
                                Qt::EditRole);
    qDebug() << "modify object " << newGodItem.getName();
    emit objectsModelChanged();
    emit notNullObjectsModelChanged();
    return 0;
}

void GodList::buyGod(int id) {
    this->databaseMutex.lock();

    GodItem item = (objectsModel->data(objectsModel->index(id, 0))).value<GodItem>();
    if (item.getCount() > 0) {
        this->modifyObject(item.getId(), item.getName(), item.getCount() - 1, item.getPrice());
    } else {

    }
    emit objectsModelChanged();
    emit notNullObjectsModelChanged();

    this->databaseMutex.unlock();
}

void GodList::addGod(QString name, int count, float price) {
    this->databaseMutex.lock();

    this->addNewObject(name, count, price);

    this->databaseMutex.unlock();
}

void GodList::modifyGod(int id, QString name, int count, float price) {
    this->databaseMutex.lock();

    this->modifyObject(id, name, count, price);

    this->databaseMutex.unlock();
}

void GodList::startThreadBuyGod(int id) {
    QFuture<void> future = QtConcurrent::run(this, &GodList::buyGod, id);
}

void GodList::startThreadAddGod(QString name,
                                int count, float price) {
    QFuture<void> future = QtConcurrent::run(this, &GodList::addGod, name, count, price);
}
void GodList::startThreadModifyGod(int id, QString name,
                                   int count, float price) {
    QFuture<void> future = QtConcurrent::run(this, &GodList::modifyGod, id, name, count, price);
}

void GodList::readFromCSV() {
    QFile file(":/resources/data.csv");
    if (!file.open(QIODevice::ReadOnly)) {
            qDebug() << file.errorString();
            return;
        }

        QStringList wordList;
        while (!file.atEnd()) {
            QString name;
            int count;
            float price;

            QByteArray line = file.readLine();
            QList<QByteArray> splitedLine = line.split(',');

            name = QString(splitedLine[0]);
            price = splitedLine[1].toDouble();
            count = splitedLine[2].toInt();
            this->addNewObject(name, count, price);
        }
}
