/// \file ExN01DetectorHit.cc
/// \brief Implementation of the ExN01DeteectorHit class

#include "ExN01DetectorHit.hh"

#include <iomanip>

#include "G4Circle.hh"
#include "G4Colour.hh"
#include "G4UnitsTable.hh"
#include "G4VVisManager.hh"
#include "G4VisAttributes.hh"

G4ThreadLocal G4Allocator<ExN01DetectorHit>* ExN01DetectorHitAllocator = 0;

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

ExN01DetectorHit::ExN01DetectorHit()
    : G4VHit(), fTrackID(-1), fKe(0.), fTl(0.) {}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

ExN01DetectorHit::~ExN01DetectorHit() {}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

ExN01DetectorHit::ExN01DetectorHit(const ExN01DetectorHit& right) : G4VHit() {
  fTrackID = right.fTrackID;
  fKe = right.fKe;
  fTl = right.fTl;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

const ExN01DetectorHit& ExN01DetectorHit::operator=(
    const ExN01DetectorHit& right) {
  fTrackID = right.fTrackID;
  fKe = right.fKe;
  fTl = right.fTl;

  return *this;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

G4int ExN01DetectorHit::operator==(const ExN01DetectorHit& right) const {
  return (this == &right) ? 1 : 0;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

void ExN01DetectorHit::Draw() {
  /*
  G4VVisManager* pVVisManager = G4VVisManager::GetConcreteInstance();
  if(pVVisManager)
  {
    G4Circle circle(fPos);
    circle.SetScreenSize(4.);
    circle.SetFillStyle(G4Circle::filled);
    G4Colour colour(1.,0.,0.);
    G4VisAttributes attribs(colour);
    circle.SetVisAttributes(attribs);
    pVVisManager->Draw(circle);
  }
  */
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

void ExN01DetectorHit::Print() {
  G4cout << "  trackID: " << fTrackID << " Kinetic Energy: " << std::setw(7)
         << G4BestUnit(fKe, "Energy") << " Track Length: " << std::setw(7)
         << G4BestUnit(fTl, "Length") << " Weight: " << std::setw(7) << fWeight
         << " name:" << std::setw(7) << fName << G4endl;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......
