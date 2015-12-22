﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace eStudentMVC5.Controllers
{
    [Authorize]
    public class UporabniskiPodatkiController : Controller
    {
        estudentEntities db = new estudentEntities();

        // GET: UporabniskiPodatki
        public ActionResult Index(int idUporabnik = 0)
        {
            try
            {
                uporabnik tren = (from s in db.uporabnik where s.email.Equals(User.Identity.Name) select s).ToList().First();
                if (idUporabnik == 0)
                {
                    return View(tren);
                }
                else
                {
                    uporabnik u = db.uporabnik.Find(idUporabnik);
                    return View(u);
                }  
            }
            catch
            {
                Log.Error("Prislo je do napake pri ugotavljanju uporabnika.");
            }
            return View(new uporabnik());
        }

        [HttpPost]
        public ActionResult Index(uporabnik u)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    if (u.idUporabnik != 0)
                    {
                        db.Entry(u).State = System.Data.Entity.EntityState.Modified;
                        int uspeh = db.SaveChanges();
                    }
                    else
                    {
                        Log.Error("Zahtevan je bil vnos novega uporabnika.");
                    }

                }
                catch
                {
                    Log.Error("Uporabnik ni bil posodobljen.");
                }
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Odpravite napake v obrazcu.");
                return View(u);
            }
            return RedirectToAction("Index");
        }
    }
}