#ifndef GODITEM_H
#define GODITEM_H

#include <QObject>
#include <QString>

class GodItem
{
    Q_GADGET
    Q_PROPERTY(int godId READ getId WRITE setId)
    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(int count READ getCount WRITE setCount)
    Q_PROPERTY(float price READ getPrice WRITE setPrice)

public:
    GodItem();
    GodItem(int id, QString name, int count, float price);

    int getId();
    QString getName();
    int getCount();
    float getPrice();

    void setId(const int &id);
    void setName(const QString &name);
    void setCount(const int &count);
    void setPrice(const float &price);


private:
    int godId;
    QString name;
    int count;
    float price;
};

#endif // GODITEM_H
