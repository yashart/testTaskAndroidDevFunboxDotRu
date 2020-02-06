#include "goditem.h"

GodItem::GodItem() {

}

GodItem::GodItem(int id, QString name, int count, float price) {
    this->godId = id;
    this->name = name;
    this->count = count;
    this->price = price;
}

int GodItem::getId() {
    return this->godId;
}
QString GodItem::getName() {
    return this->name;
}
int GodItem::getCount() {
    return this->count;
}
float GodItem::getPrice() {
    return this->price;
}

void GodItem::setId(const int &id) {
    this->godId = id;
}
void GodItem::setName(const QString &name) {
    this->name = name;
}
void GodItem::setCount(const int &count) {
    this->count = count;
}
void GodItem::setPrice(const float &price) {
    this->price = price;
}
